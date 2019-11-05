class User < ApplicationRecord
validates :nickname , {presence: true , {uniqueness: true}}
validates :password , {presence: true}
end
