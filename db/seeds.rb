# Create Attacks
# To delete all attacks AND reset the primary key
#
# Attack.destroy_all
# ActiveRecord::Base.connection.reset_pk_sequence!(Attack.table_name)
#
# Then you can seed the database and start with the primary key at 1!
attacks_seed_file = File.join(Rails.root, 'db', 'attacks.yml')
attacks = YAML::load_file(attacks_seed_file)

def load_from_yaml(filename)
  file = File.join(Rails.root, 'db', filename)
  return YAML::load_file(file)
end

def create_if_not_exists(cls, objects, attr)
  objects.each do |new_obj|
    obj = cls.where("#{attr}" => new_obj[attr]).first
    if obj
      puts "Already had #{cls}: #{new_obj[attr]}."
    else
      obj = cls.new(new_obj)
      if obj.save
        puts "Created #{cls}: #{new_obj[attr]}."
      else
        puts "An error occurred while creating #{cls} #{new_obj[attr]}."
      end
    end
  end
end

attacks = load_from_yaml('attacks.yml')
create_if_not_exists(Attack, attacks, 'name')

items = load_from_yaml('items.yml')
create_if_not_exists(Item, items, 'name')
