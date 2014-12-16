json.array!(@voters) do |voter|
  json.extract! voter, :id, :cnp, :last_name, :first_name, :address, :zone, :user_id
  json.url voter_url(voter, format: :json)
end
