module EnrollmentsHelper

     def display_price
          if @enrollemnt.price > 30 
               content_tag(:h5, "Price: #{number_to_currency(@enrollment.price)}")
          else 
               content_tag(:h2, "Price: #{number_to_currency(@enrollment.price)}")
          end  
     end


     def display_header(instrument)
          if @enrollment
               tag.h1("All #{instrument.name}'s Enrollments")
          else
               tag.h2("All the Enrollments")
          end

     end

end