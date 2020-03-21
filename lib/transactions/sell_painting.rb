# frozen_string_literal: true

module Transactions
  class SellPainting
    include Dry::Transaction(container: Application)

    include Import['db', 'repo.painting_repo', 'repo.user_repo']

    step :fetch_painting
    step :check_painting
    step :fetch_user
    step :check_user_balance
    tee :sell_painting

    private

    def fetch_painting(input)
      painting_id = input.fetch :painting_id
      painting = painting_repo.find(painting_id)

      return Failure('Картина не найдена') unless painting

      Success(input.merge(painting: painting))
    end

    def check_painting(input)
      painting = input.fetch(:painting)

      return Failure('Картина продана') if painting[:sold]

      Success(input)
    end

    def fetch_user(input, user_id:)
      user = user_repo.find(user_id)

      return Failure('Пользователь не найден') unless user

      Success(input.merge(user: user))
    end

    def check_user_balance(input)
      painting = input.fetch(:painting)
      user = input.fetch(:user)

      return Failure('Недостаточно средств') if user[:balance] < painting[:price]

      Success(input)
    end

    def sell_painting(input)
      painting = input.fetch(:painting)
      user = input.fetch(:user)

      db.transaction do
        painting_repo.update_attributes(painting[:id], sold: true)
        user_repo.update_attributes(user[:id], balance: user[:balance] - painting[:price])
      end
    end
  end
end
