# Create Attacks
# To delete all attacks AND reset the primary key
#
# Attack.destroy_all
# ActiveRecord::Base.connection.reset_pk_sequence!(Attack.table_name)
#
# Then you can seed the database and start with the primary key at 1!
attacks_seed_file = File.join(Rails.root, 'db', 'attacks.yml')
attacks = YAML::load_file(attacks_seed_file)

attacks.each do |new_attack|
  attack = Attack.find_by_name(new_attack['name'])
  if attack
    puts "Already had attack: #{attack.name}."
  else
    attack = Attack.new(new_attack)
    if attack.save
      puts "Created attack: #{attack.name}."
    else
      puts "An error occurred while creating: #{new_attack['name']}."
    end
  end
end
