require 'pry'


class Waiter

  attr_accessor :name, :yrs_experience

  @@all = []

  def initialize(name, yrs_experience)
    @name = name
    @yrs_experience = yrs_experience
    self.class.all << self
  end

  def self.all
    @@all
  end

  def new_meal (customer, total, tip)
    Meal.new(self, customer, total, tip)
  end

  def meals
    Meal.all.select do |meal|
      meal.waiter == self #checking for waiter now
    end
  end

  def best_tipper
    best_tipped_meal = meals.max do |meal_a, meal_b|
      meal_a.tip <=> meal_b.tip
    end
    best_tipped_meal.customer
  end

  def most_frequent_customer
    customers = []
    Meal.all.each do |meal|
      customers << meal.customer
    end
    cust_nums = customers.inject(Hash.new(0)) { |hash, cust| hash[cust] += 1; hash }
    customers.max_by { |v| cust_nums[v] }
  end

end
