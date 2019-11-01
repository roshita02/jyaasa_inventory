# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemAssignmentMailer, type: :mailer do
  describe 'notify' do
    let(:mail) { ItemAssignmentMailer.new }

    it 'renders the headers' do
      expect(mail.subject).to eq('New Item Assignment')
      expect(mail.from).to eq(['admin@example.com'])
    end
  end
end
