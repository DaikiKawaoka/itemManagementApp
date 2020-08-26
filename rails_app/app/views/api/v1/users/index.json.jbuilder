json.array! @users do |user|
  json.id user.id
  json.name user.name
  json.user_name user.user_name
  json.email user.email
  json.comment user.comment
  json.password_digest user.password_digest
  json.create_at user.created_at
end