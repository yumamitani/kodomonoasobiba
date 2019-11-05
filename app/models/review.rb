class Review < ApplicationRecord
  validates:nickname,{presence:true}
  validates:prefecture,{presence:true}
  validates:subject,{presence:true}
  validates:text,{presence:true , length:{maximum:200}}
end
