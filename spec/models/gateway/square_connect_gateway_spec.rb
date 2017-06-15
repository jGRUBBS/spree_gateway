require 'spec_helper'

describe Spree::Gateway::SquareConnectGateway do

  let(:application_id) { 'app_id' }

  let(:provider) do
    double('provider').tap do |p|
      p.stub(:purchase)
      p.stub(:authorize)
      p.stub(:capture)
    end
  end

  before do
    subject.preferences = { application_id: application_id }
    subject.stub(:options_for_purchase_or_auth).and_return(['money','cc','opts'])
    subject.stub(:provider).and_return provider
  end

  describe '#create_profile' do
  end

  context 'purchasing' do
    after do
      subject.purchase(19.99, 'credit card', {})
    end

    it 'send the payment to the provider' do
      provider.should_receive(:purchase).with('money','cc','opts')
    end
  end

  context 'authorizing' do
  end

  context 'capturing' do
  end

  context 'capture with payment class' do
  end

end