# frozen_string_literal: true

RSpec.describe Oyi::VirtualAccount do
  it '.create new VA with valid data' do
    VCR.use_cassette(:valid_virtual_account_create) do
      response = Oyi::VirtualAccount.create partner_user_id: SecureRandom.uuid, bank_code: '002',
                                            amount: 30_000, partner_trx_id: SecureRandom.uuid
      expect(response['va_number']).to_not be_nil
    end
  end

  it '.create new VA with valid data' do
    VCR.use_cassette(:invalid_virtual_account_create) do
      expect do
        Oyi::VirtualAccount.create partner_user_id: SecureRandom.uuid, bank_code: '909',
                                   amount: 30_000, partner_trx_id: SecureRandom.uuid
      end.to raise_error(Oyi::Error)
    end
  end

  it '.get VA details' do
    VCR.use_cassette(:valid_virtual_account_get) do
      create_response = Oyi::VirtualAccount.create partner_user_id: SecureRandom.uuid, bank_code: '002',
                                                   amount: 30_000, partner_trx_id: SecureRandom.uuid
      response = Oyi::VirtualAccount.get(create_response['id'])
      expect(response['va_number']).to eq(create_response['va_number'])
    end
  end

  it '.get VA details' do
    VCR.use_cassette(:valid_virtual_account_update) do
      create_response = Oyi::VirtualAccount.create partner_user_id: SecureRandom.uuid, bank_code: '002',
                                                   amount: 30_000, partner_trx_id: SecureRandom.uuid
      response = Oyi::VirtualAccount.update(create_response['id'], is_single_use: true)
      expect(response['is_single_use']).to be_truthy
    end
  end

  it '.all lists all VAs' do
    VCR.use_cassette(:valid_virtual_account_all) do
      response = Oyi::VirtualAccount.all
      expect(response['data']).not_to be_nil
    end
  end

  it '.transactions lists all transaction for a VA' do
    VCR.use_cassette(:valid_virtual_account_transaction) do
      create_response = Oyi::VirtualAccount.create partner_user_id: SecureRandom.uuid, bank_code: '002',
                                                   amount: 30_000, partner_trx_id: SecureRandom.uuid
      response = Oyi::VirtualAccount.transactions(create_response['id'])
      expect(response['data']).not_to be_nil
    end
  end
end
