# frozen_string_literal: true

RSpec.describe Oyi::Acceptance do
  it '.payment_checkout creates payment link for valid input' do
    VCR.use_cassette(:valid_acceptance_payment_checkout) do
      response = Oyi::Acceptance.payment_checkout partner_tx_id: SecureRandom.uuid, amount: 15_000, email: 'user@example.com'
      expect(response['url']).not_to be_nil
    end
  end

  it '.payment_checkout throws an exception for invalid input' do
    VCR.use_cassette(:invalid_acceptance_payment_checkout) do
      expect do
        partner_tx_id = SecureRandom.uuid
        Oyi::Acceptance.payment_checkout partner_tx_id: partner_tx_id, amount: 15_000, email: 'user@example.com'
        Oyi::Acceptance.payment_checkout partner_tx_id: partner_tx_id, amount: 15_000, email: 'user@example.com'
      end.to raise_error(Oyi::ApiError)
    end
  end

  it '.create_invoice generates payment link with invoice details for valid input' do
    VCR.use_cassette(:valid_acceptance_create_invoice) do
      response = Oyi::Acceptance.create_invoice partner_tx_id: SecureRandom.uuid, amount: 15_000, email: 'user@example.com'
      expect(response['url']).not_to be_nil
    end
  end

  it '.create_invoice throws and exception for invalid input' do
    VCR.use_cassette(:invalid_acceptance_create_invoice) do
      expect do
        partner_tx_id = SecureRandom.uuid
        Oyi::Acceptance.create_invoice partner_tx_id: partner_tx_id, amount: 15_000, email: 'user@example.com'
        Oyi::Acceptance.create_invoice partner_tx_id: partner_tx_id, amount: 15_000, email: 'user@example.com'
      end.to raise_error(Oyi::ApiError)
    end
  end

  it '.status returns the status of a transaction for valid input' do
    partner_tx_id = '9b6b65f0-c56f-4eb3-b29f-dd0aac353736'
    VCR.use_cassette(:valid_acceptance_status) do
      Oyi::Acceptance.create_invoice partner_tx_id: partner_tx_id, amount: 15_000, email: 'user@example.com'
      response = Oyi::Acceptance.status(partner_tx_id: partner_tx_id)
      expect(response['data']).not_to be_nil
    end
  end

  it '.status returns nil data for invalid input' do
    VCR.use_cassette(:invalid_acceptance_status) do
      response = Oyi::Acceptance.status(partner_tx_id: '6b363f43-266e-4490-a9cb-82a8111086ba')
      expect(response['data']).to be_nil
    end
  end

  it '.delete delets a payment link for valid input' do
    partner_tx_id = 'c58bbf25-8daf-44e2-8d1a-345c000406733'
    VCR.use_cassette(:valid_acceptance_delete) do
      Oyi::Acceptance.create_invoice partner_tx_id: partner_tx_id, amount: 15_000, email: 'user@example.com'
      response = Oyi::Acceptance.delete(payment_link_id_or_partner_tx_id: partner_tx_id)
      expect(response['status']).to be_truthy
    end
  end

  it '.delete throws an exception for invalid input' do
    VCR.use_cassette(:invalid_acceptance_delete) do
      expect do
        Oyi::Acceptance.delete(payment_link_id_or_partner_tx_id: '7992d538a-7558-4672-8988-29861d62fb12')
      end.to raise_error(Oyi::ApiError)
    end
  end

  it '.get gets the details of a payment link for valid input' do
    payment_link_id_or_partner_tx_id = '825a0668-dbd8-4c38-87d0-fa0bbb745567'
    VCR.use_cassette(:valid_acceptance_get) do
      Oyi::Acceptance.create_invoice partner_tx_id: payment_link_id_or_partner_tx_id, amount: 15_000, email: 'user@example.com'
      response = Oyi::Acceptance.get(payment_link_id_or_partner_tx_id: payment_link_id_or_partner_tx_id)
      expect(response['data']).not_to be_nil
    end
  end

  it '.get throws an exception for invalid input' do
    VCR.use_cassette(:invalid_acceptance_delete) do
      expect do
        Oyi::Acceptance.get(payment_link_id_or_partner_tx_id: '7992d338a-7558-4672-8988-29861d62fb12')
      end.to raise_error(Oyi::ApiError)
    end
  end
end
