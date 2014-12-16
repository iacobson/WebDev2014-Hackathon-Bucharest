class Voter < ActiveRecord::Base
  belongs_to :user
  self.primary_key = 'cnp'

  #def to_param
  #  cnp.parameterize
  #end

end
