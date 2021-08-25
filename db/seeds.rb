# frozen_string_literal: true

require 'faker'

Product.destroy_all
# rubocop:disable Layout/LineLength

Product.create(name: 'Монтанара', price: 12,
               ingredients: 'томатный соус, крем-чиз соус, сыр моцарелла, салями пепперони, бекон в/к, пармезан, орегано',
               description: 'вкусно', weight: 470, photo: 'montanara', position: 1)
Product.create(name: 'Мясная', price: 12,
               ingredients: 'томатный соус, сыр моцарелла, говядина в/к, бекон в/к, руккола, орегано',
               description: 'вкусно', weight: 480, photo: 'meaty', position: 2)
Product.create(name: 'Огонь', price: 12,
               ingredients: 'томатно-сырный соус, сыр моцарелла, колбаска Пепперони, филе куриное в/к, орегано',
               description: 'вкусно', weight: 510, photo: 'fire', position: 3)
Product.create(name: 'Баварская', price: 10,
               ingredients: 'томатный соус, сыр моцарелла, колбаски охотничьи, шампиньоны, огурчик маринованный, соус горчичный, орегано',
               description: 'вкусно', weight: 480, photo: 'bavarian', position: 4)
Product.create(name: 'Барбекю', price: 14,
               ingredients: 'томатный соус, соус Барбекю, бекон в/к, филе куриное в/к, лучок маринованный, шампиньоны, оливки, орегано',
               description: 'вкусно', weight: 520, photo: 'barbekyu', position: 5)
Product.create(name: 'Ветчина Грибы', price: 12,
               ingredients: 'томатный соус, сыр моцарелла, ветчина в/к, бекон в/к, шампиньоны, огурчик маринованный, орегано',
               description: 'вкусно', weight: 480, photo: 'vetchina', position: 6)
Product.create(name: 'Курица и сладкий перчик', price: 12,
               ingredients: 'томатный соус, сыр моцарелла, филе куриное в/к, бекон в/к, сладкий перчик, орегано',
               description: 'вкусно', weight: 480, photo: 'chicken', position: 7)
Product.create(name: 'Пепперони', price: 10,
               ingredients: 'томатный соус, сыр моцарелла, колбаска Пепперони, орегано',
               description: 'вкусно', weight: 420, photo: 'pepperoni', position: 8)
Product.create(name: 'Примавера', price: 14,
               ingredients: 'томатный соус, сыр моцарелла, перчик болгарский, соус песто, каперсы, руккола, пармезан, орегано',
               description: 'вкусно', weight: 470, photo: 'primavera', position: 9)
Product.create(name: 'Четыре сыра', price: 14,
               ingredients: 'томатный соус, сыр моцарелла, Дор Блю, Чеддер, Пармезан, орегано, базилик',
               description: 'вкусно', weight: 420, photo: 'fourcheeses', position: 10)
Product.create(name: 'Маргарита', price: 8, ingredients: 'томатный соус, сыр моцарелла, орегано, базилик',
               description: 'вкусно', weight: 380, photo: 'margarita', position: 11)
# rubocop:enable Layout/LineLength
10.times do |i|
  name = Faker::Dessert.variety
  price = Faker::Number.number(digits: 2)
  ingredients = Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4)
  description = Faker::Lorem.word
  weight = Faker::Number.number(digits: 3)
  position = i + 12
  Product.create(name: name, price: price, ingredients: ingredients, description: description, weight: weight,
                 photo: 'none', position: position)
end

logger.info "Total number of products: #{Product.all.count}"
logger.info "Product names: #{Product.all.pluck('name')}"
