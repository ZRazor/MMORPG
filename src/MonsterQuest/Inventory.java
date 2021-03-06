package MonsterQuest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.util.Collection;
import java.util.Collections;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by razoriii on 29.04.14.
 */ //TODO объект бонус
public class Inventory {
   private final ConcurrentHashMap<Long, Item> items = new ConcurrentHashMap<>();
   private Bonus bonus;

   protected Collection<Item> getItems() {
      return Collections.unmodifiableCollection(items.values());
   }

   protected void removeItem(Item item) {
      items.remove(item.getId());
      calcBonus();
   }

   protected void removeItem(Long itemId) {
      items.remove(itemId);
      calcBonus();
   }

   protected Item getItem(Long itemId) {
      return items.get(itemId);
   }

   protected void addItem(Item item) {
      items.put(item.getId(), item);
      calcBonus();
   }

   public void dropItem(Long itemId, Location newLocation, Inventory destInventory) {
      //TODO проверять куда падает
      Item item = items.get(itemId);
      item.setLocation(new Location(newLocation));
      removeItem(item);
      destInventory.addItem(item);
   }

   public void dropAllItems(Location newLocation , Inventory destInventory) { //TODO убрать класс из game
      for (Item item:getItems()) {
         item.setLocation(newLocation);
         destInventory.addItem(item);
      }
   }

   public void pickUpItem(Long itemId, Inventory sourceInventory) {
      Item item = Game.getDroppedItems().getItem(itemId);
      sourceInventory.removeItem(itemId);
      addItem(item);
   }

   public Bonus calcBonus(){
      bonus = new Bonus();
      for (Item item : getItems()){
         if (item.isEquipped()){
            bonus.addBonus(item.getBonus());
         }
      }
      return bonus;
   }

   public JSONArray inventoryToJSON() {
      JSONArray result = new JSONArray();
      for (Item item : getItems()) {
         JSONObject itemData = new JSONObject();
         itemData.put("name", item.getName());
         itemData.put("id", item.getId());
         itemData.put("type", item.getType());
         itemData.put("description", item.getDescription());
         itemData.put("x", item.getLocation().x);
         itemData.put("y", item.getLocation().y);
         result.add(itemData);
      }
      return result;
   }

}
