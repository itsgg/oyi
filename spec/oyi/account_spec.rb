# frozen_string_literal: true

RSpec.describe Oyi::Account do

  let(:valid_bank_code) { '008' }
  let(:invalid_bank_code) { '999' }
  let(:account_number) { '23432423423432434' }

  it '.inquery gets beneficiery account details for valid input' do
    VCR.use_cassette(:valid_account_inquiry) do
      response = Oyi::Account.inquiry(bank_code: valid_bank_code, account_number: account_number)
      expect(response).to have_key('account_name')
    end
  end

  it '.inquery throws exception for invalid input' do
    VCR.use_cassette(:invalid_account_inquiry) do
      expect do
        Oyi::Account.inquiry(bank_code: invalid_bank_code, account_number: account_number)
      end.to raise_error(Oyi::ApiError)
    end
  end
end
