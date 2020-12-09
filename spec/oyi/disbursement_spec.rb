# frozen_string_literal: true

RSpec.describe Oyi::Disbursement do
  let(:valid_bank_code) { '008' }
  let(:invalid_bank_code) { '999' }
  let(:account_number) { '23432423423432434' }

  it '.account_inquery gets beneficiery account details for valid input' do
    VCR.use_cassette(:valid_disbursement_account_inquiry) do
      response = Oyi::Disbursement.account_inquiry(recipient_bank: valid_bank_code, recipient_account: account_number)
      expect(response).to have_key('recipient_account')
    end
  end

  it '.account_inquery throws exception for invalid input' do
    VCR.use_cassette(:invalid_disbursement_account_inquiry) do
      expect do
        Oyi::Disbursement.account_inquiry(recipient_bank: invalid_bank_code, recipient_account: account_number)
      end.to raise_error(Oyi::ApiError)
    end
  end

  it '.remit disburses for valid input' do
    VCR.use_cassette(:valid_disbursement_remit) do
      response = Oyi::Disbursement.remit recipient_bank: valid_bank_code, recipient_account: account_number,
                                         amount: 200_000, partner_trx_id: SecureRandom.uuid
      expect(response['trx_id']).not_to be_empty
    end
  end

  it '.remit throws exception for invalid input' do
    VCR.use_cassette(:invalid_disbursement_remit) do
      expect do
        Oyi::Disbursement.remit recipient_bank: invalid_bank_code, recipient_account: account_number,
                                amount: 200_000, partner_trx_id: SecureRandom.uuid
      end.to raise_error(Oyi::ApiError)
    end
  end

  it '.balance gets valid data' do
    VCR.use_cassette(:valid_disbursement_balance) do
      response = Oyi::Disbursement.balance
      expect(response['balance']).not_to be_nil
    end
  end

  it '.scheduled_remit creates a scheduled remitance for valid input' do
    VCR.use_cassette(:valid_disbursement_scheduled_remit) do
      response = Oyi::Disbursement.schedule_remit recipient_bank: valid_bank_code, recipient_account: account_number,
                                                  amount: 200_000, partner_trx_id: SecureRandom.uuid,
                                                  schedule_date: '12-12-2030'
      expect(response['scheduled_trx_status']).to eq('SCHEDULED')
    end
  end

  it '.scheduled_remit throws exception for invalid input' do
    VCR.use_cassette(:invalid_disbursement_scheduled_remit) do
      expect do
        Oyi::Disbursement.schedule_remit recipient_bank: valid_bank_code, recipient_account: account_number,
                                         amount: 200_000, partner_trx_id: SecureRandom.uuid,
                                         schedule_date: '12-12-2010'
      end.to raise_error(Oyi::ApiError)
    end
  end

  it '.scheduled_remit_details returns status for valid input' do
    partner_trx_id = SecureRandom.uuid
    VCR.use_cassette(:valid_disbursement_scheduled_remit_details) do
      Oyi::Disbursement.schedule_remit recipient_bank: valid_bank_code, recipient_account: account_number,
                                       amount: 200_000, partner_trx_id: partner_trx_id,
                                       schedule_date: '12-12-2030'
      response = Oyi::Disbursement.scheduled_remit_details partner_trx_id: partner_trx_id
      expect(response).to have_key('scheduled_trx_status')
    end
  end

  it '.scheduled_remit_details throws exception for invalid input' do
    VCR.use_cassette(:invalid_disbursement_scheduled_remit_details) do
      expect do
        Oyi::Disbursement.scheduled_remit_details partner_trx_id: SecureRandom.uuid
      end.to raise_error(Oyi::ApiError)
    end
  end

  it '.list_scheduled_remit' do
    VCR.use_cassette(:valid_disbursement_list_scheduled_remits) do
      response = Oyi::Disbursement.list_scheduled_remit
      expect(response['data']).not_to be_nil
    end
  end

  it '.cancel_scheduled_remit with valid data' do
    partner_trx_id = '1e0a6d1a-3c28-4c18-b991-1a65552164c5'
    VCR.use_cassette(:valid_disbursement_cancel_scheduled_remits) do
      Oyi::Disbursement.schedule_remit recipient_bank: valid_bank_code, recipient_account: account_number,
                                       amount: 200_000, partner_trx_id: partner_trx_id,
                                       schedule_date: '12-12-2030'
      response = Oyi::Disbursement.cancel_scheduled_remit partner_trx_id: partner_trx_id
      expect(response['scheduled_trx_status']).to eq('CANCELLED')
    end
  end

  it '.cancel_scheduled_remit throws exception with invalid data' do
    VCR.use_cassette(:invalid_disbursement_cancel_scheduled_remits) do
      expect do
        Oyi::Disbursement.cancel_scheduled_remit(partner_trx_id: '61682057-615d-44b4-8922-ce524b4c372b')
      end.to raise_error(Oyi::ApiError)
    end
  end

  it '.retry_scheduled_remit with valid data' do
    old_partner_trx_id = '72585348-a957-44fb-bf0b-8fdd57ff1b4b'
    new_partner_trx_id = '2f3eb1b2-a742-4606-a201-bbe11aea2eba4'
    VCR.use_cassette(:valid_disbursement_retry_scheduled_remits) do
      Oyi::Disbursement.schedule_remit recipient_bank: valid_bank_code, recipient_account: account_number,
                                       amount: 200_000, partner_trx_id: old_partner_trx_id,
                                       is_trigger_based: true, trigger_date: '12-12-2030',
                                       trigger_email: 'me@itsgg.com', cs_phone_number: '+83434324324324',
                                       cs_email: 'support@beecash.io'

      Oyi::Disbursement.cancel_scheduled_remit partner_trx_id: old_partner_trx_id
      response = Oyi::Disbursement.retry_scheduled_remit old_partner_trx_id: old_partner_trx_id,
                                                         new_partner_trx_id: new_partner_trx_id,
                                                         trigger_date: '12-12-2040'
      expect(response['scheduled_trx_status']).to eq('SCHEDULED')
    end
  end

  it '.retry_scheduled_remit with invalid data' do
    VCR.use_cassette(:invalid_disbursement_retry_scheduled_remits) do
      expect do
        Oyi::Disbursement.retry_scheduled_remit old_partner_trx_id: 'ef3fd32d-d491-4df8-bdae-c7fd6950cd36',
                                                new_partner_trx_id: 'bd91d2de-32d4-4972-b3b6-1fd0f3a846fd',
                                                trigger_date: '12-12-2030'
      end.to raise_error(Oyi::ApiError)
    end
  end
end
