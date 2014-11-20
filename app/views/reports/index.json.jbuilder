json.array!(@reports) do |report|
  json.extract! report, :id, :title
  json.url report_url(report, format: :json)
end
