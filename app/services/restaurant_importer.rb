# app/services/restaurant_importer.rb
class RestaurantImporter
  attr_reader :logs, :errors

  def initialize(data)
    @data   = data
    @logs   = []
    @errors = []
  end

  def run
    ActiveRecord::Base.transaction do
      @data.each { |restaurant_data| import_restaurant(restaurant_data) }
    end
  rescue StandardError => e
    @errors << "Import failed: #{e.message}"
    false
  end

  private

  def import_restaurant(restaurant_data)
    restaurant = Restaurant.find_or_initialize_by(name: restaurant_data['name'])
    restaurant.address = restaurant_data['address']
    restaurant.phone = restaurant_data['phone']

    if restaurant.save
      @logs << "Restaurant '#{restaurant.name}' imported successfully"
      import_menus(restaurant, restaurant_data['menus'])
    else
      @errors << "Failed to import restaurant '#{restaurant_data['name']}': #{restaurant.errors.full_messages.join(', ')}"
    end
  end

  def import_menus(restaurant, menus_data)
    menus_data.each do |menu_data|
      menu = restaurant.menus.find_or_initialize_by(name: menu_data['name'])
      menu.description = menu_data['description']

      if menu.save
        @logs << "Menu '#{menu.name}' imported successfully for restaurant '#{restaurant.name}'"
        import_menu_items(menu, menu_data['items'])
      else
        @errors << "Failed to import menu '#{menu_data['name']}' for restaurant '#{restaurant.name}': #{menu.errors.full_messages.join(', ')}"
      end
    end
  end

  def import_menu_items(menu, items_data)
    items_data.each do |item_data|
      item = menu.menu_items.find_or_initialize_by(name: item_data['name'])
      item.description = item_data['description']
      item.price = item_data['price']

      if item.save
        @logs << "Menu item '#{item.name}' imported successfully for menu '#{menu.name}'"
      else
        @errors << "Failed to import menu item '#{item_data['name']}' for menu '#{menu.name}': #{item.errors.full_messages.join(', ')}"
      end
    end
  end
end