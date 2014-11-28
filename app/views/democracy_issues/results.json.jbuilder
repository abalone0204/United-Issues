json.votes @candidates do |candidate|
  json.label candidate.name
  json.value candidate.votes.count
end