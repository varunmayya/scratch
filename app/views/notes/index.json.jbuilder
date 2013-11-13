json.array!(@notes) do |note|
  json.extract! note, :data, :user_id
  json.url note_url(note, format: :json)
end
