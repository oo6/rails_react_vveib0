class API < Grape::API
  prefix 'api'
  format :json
  content_type :json, 'application/json;charset=utf-8'

  mount V1::Root
end