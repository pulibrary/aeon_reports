require 'csv'
require 'set'

# read identifiers and whether or not they're in the narrower set
hellenic_status = {}
CSV.read('identifiers_Hellenic.csv', headers: true).each do |row|
  identifier = row['identifiers'].to_s.strip
  hellenic_match = row['matches_narrower?'].to_s.strip.downcase == 'true'
  hellenic_status[identifier] = hellenic_match
end

identifiers_to_match = Set.new(hellenic_status.keys)

# write each matching transactions row to the output file, with checkboxes for broader and narrower matches
CSV.open('Aeon_transactions_Hellenic.csv', 'w') do |output|
  first_row = true
  CSV.foreach('Aeon_Transactions_helper.csv', headers: true) do |row|
    if first_row
      output << row.headers + ['broader_match', 'matched_identifier', 'narrower_match']
      first_row = false
    end
    
    match_found = [row['ItemNumber'], row['ReferenceNumber'], row['CallNumber'], row['callnumber_helper']].find do |id|
      identifiers_to_match.include?(id.to_s.strip)
    end
    
    row['broader_match'] = match_found ? '✓' : ''
    row['matched_identifier'] = match_found || ''
    row['narrower_match'] = match_found && hellenic_status[match_found.to_s.strip] ? '✓' : ''
    
    output << row
  end
end
