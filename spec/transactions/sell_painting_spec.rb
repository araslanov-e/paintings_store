# frozen_string_literal: true

describe Transactions::SellPainting do
  # TODO: DatabaseCleaner
  after(:all) do
    Application['db'][:users].delete
    Application['db'][:paintings].delete
  end

  describe '.call' do
    let(:user_id) { 0 }

    subject do
      described_class.new
        .with_step_args(fetch_user: [user_id: user_id])
        .call(painting_id: painting_id) do |m|
          m.success {}
          m.failure { |error| error }
        end
    end

    context 'when painting is not found' do
      let(:painting_id) { 0 }
      it { is_expected.to eq 'Картина не найдена' }
    end

    context 'when painting is found' do
      let(:painting_id) { painting[:id] }
      let(:painting) { create :painting, price: 50, sold: sold }
      let(:sold) { false }

      context 'when painting is sold out' do
        let(:sold) { true }

        it { is_expected.to eq 'Картина продана' }
      end

      context 'when user is not found' do
        it { is_expected.to eq 'Пользователь не найден' }
      end

      context 'when user is found' do
        let(:user) { create :user, balance: balance }
        let(:user_id) { user[:id] }

        context 'when user does not have enough money' do
          let(:balance) { 40 }

          it { is_expected.to eq 'Недостаточно средств' }
        end

        context 'when user buy painting' do
          let(:balance) { 100 }

          it 'balance decreases and painting is sold' do
            is_expected.to eq nil
            expect(Repo::UserRepo.new.find(user_id)[:balance]).to eq 50
            expect(Repo::PaintingRepo.new.find(painting_id)[:sold]).to eq true
          end
        end
      end
    end
  end
end
