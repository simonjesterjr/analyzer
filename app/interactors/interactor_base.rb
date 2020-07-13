# frozen_string_literal: true
class InteractorBase
  include Interactor

  def errors
    @errors ||= []
  end

  def add_error( message, ex = nil )
    result = {
        message: message
    }

    result.merge( { exception: ex } ) unless ex.blank?
    errors << result
  end
end
