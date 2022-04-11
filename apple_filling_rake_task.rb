
namespace :apple_filling_rake_task do 
    task :apple_filling_rake => :environment do |variety,count|
        all_baskets = Basket.all.order('capacity ASC')
        
        filled_total_count = 0
				target_fill_count = count.deep_dup
      
            all_baskets.each do |basket|
              if filled_total_count < target_fill_count
								is_eligible = check_basket_eligibility(basket)
								if is_eligible
									fill_with_apples(basket,count,variety)
									filled_total_count += basket.apples.count
									count = count-basket.apples.count
								else
									puts "basket is not eligible"
									next
								end
							else
								puts "All Baskets Are Full"
              end
            end
    end


    def fill_with_apples(basket,count,variety)
        basket_capacity = basket.apples.count
        if count >= basket_capacity
           filling_count = 0
            while(filling_count < basket_capacity)
                basket.apples.create(variety: variety)
                filling_count+=1
            end
						new_fill_rate = calculate_fill_rate(filling_count,basket_capacity)
						basket.update(fill_rate: new_fill_rate)
        else
            basket_capacity = basket.apples.count - count
            filling_count = 0
            while(filling_count < basket_capacity)
                basket.apples.create(variety: variety)
                filling_count+=1
            end
						new_fill_rate = calculate_fill_rate(filling_count,basket_capacity)
						basket.update(fill_rate: new_fill_rate)
        end
			
    end

    def check_basket_eligibility(basket,variety)
        basket.apples.count == 0 || basket.apples.where(variety: variety).count > 1
    end
    
		def calculate_fill_rate(filling_count,basket_capacity)
			(filling_count/basket_capacity)*100
    end
end
