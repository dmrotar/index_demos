def generate_data(size)
  (1..size).map do |i|
    if i%10000 == 0
      puts i
    end
    countries = Array.new(rand(1..4)).fill { Forgery('address').country }
    age = rand(18..80)
    decade = (2025 - age) / 10 * 10
    [i, Forgery(:name).last_name, Forgery(:name).first_name, Forgery('address').phone, age, decade, Forgery('basic').color, "{#{countries.join(",")}}"]
  end
end

def save_csv(name, data)
  CSV.open("#{name}.csv", "w") do |csv|
    data.each do |row|
      csv << row
    end
  end
end

def run
  data_large = generate_data(5000000)
  data = data_large[0..4999]

  by_last_name = data.sort_by{|r|r[1]}.map{|r| [r[1],r[0]]}
  by_first_name = data.sort_by{|r|r[2]}.map{|r| [r[2],r[0]]}
  by_phone = data.sort_by{|r|r[3]}.map{|r| [r[3],r[0]]}
  by_age = data.sort_by{|r|r[4]}.map{|r| [r[4],r[0]]}
  by_decade = data.sort_by{|r|r[5]}.map{|r| [r[5],r[0]]}
  by_fav_color = data.sort_by{|r|r[6]}.map{|r| [r[6],r[0]]}

  by_last_name_and_first_name = data.sort_by{|r|[r[1],r[2]]}.map{|r| [r[1],r[2],r[0]]}
  by_last_name_and_first_name_and_age = data.sort_by{|r|[r[1],r[2],r[4]]}.map{|r| [r[1],r[2],r[4],r[0]]}
  by_age_and_fav_color = data.sort_by{|r|[r[4], r[6]]}.map{|r| [r[4], r[6],r[0]]}
  by_and_fav_color_and_age = data.sort_by{|r|[r[6], r[4]]}.map{|r| [r[6], r[4],r[0]]}
  by_first_name_and_phone = data.sort_by{|r|[r[2],r[3]]}.map{|r| [r[2],r[3],r[0]]}
  by_phone_and_first_name = data.sort_by{|r|[r[3],r[2]]}.map{|r| [r[3],r[2],r[0]]}
  by_decade_and_age = data.sort_by{|r|[r[5],r[4]]}.map{|r| [r[5],r[4],r[0]]}

  save_csv("main", data)
  save_csv("main_large", data_large)
  save_csv("by_last_name", by_last_name)
  save_csv("by_first_name", by_first_name)
  save_csv("by_age", by_age)
  save_csv("by_fav_color", by_fav_color)
  save_csv("by_phone", by_phone)
  save_csv("by_last_name_and_first_name", by_last_name_and_first_name)
  save_csv("by_last_name_and_first_name_and_age", by_last_name_and_first_name_and_age)
  save_csv("by_age_and_fav_color", by_age_and_fav_color)
  save_csv("by_fav_color_and_age", by_and_fav_color_and_age)
  save_csv("by_first_name_and_phone", by_first_name_and_phone)
  save_csv("by_phone_and_first_name", by_phone_and_first_name)
  save_csv("by_decade_and_age", by_decade_and_age)
end

