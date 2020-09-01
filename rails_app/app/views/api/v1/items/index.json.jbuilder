json.array! @items do |item|
  json.id item.id
  json.name item.name
  json.comment item.comment
  json.assessment item.assessment
  json.item_type item.item_type
  json.favorite item.favorite
  json.price item.price
  json.purchase_of_place item.purchase_of_place
  json.purchase_date item.purchase_date
  json.imgtext item.imgtext
end

