# frozen_string_literal: true

require 'bundler/setup'

require 'dry/transaction'

require_relative 'container'
require_relative 'import'

Application.finalize!
