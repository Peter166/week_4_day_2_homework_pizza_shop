require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('./models/pizza_order.rb') #need it to call funcions rom that fiel
also_reload('.models/*')# when we make changes to any file in models folder automatic reload. (do iit automatickly)
# we want to match crud to http verbs to allow html and database to tlk to each other



#This controller will return some html that shows all of the pizza orders in a nice list.

get '/pizza-orders' do # always talk about plurar.
  #we first need to get all the pizzas orders.
  #then we will pass the pizza oredrs into @global variable.
   @orders = PizzaOrder.all
  #render the index route html.
  erb(:index) # this is where all the data will be displayed.
end


# This route should return a html page that has a form to create new pizza orders.
get '/pizza-orders/new' do
  erb(:new)

end




#This route should return some html that shows single pizza order.
get '/pizza-orders/:id' do
  #fist grab the order id from url.
  order_id = params[:id]
  #Get pizza order - by calling find function onPizzaOrder and by passsing the id we got from params.
  @order = PizzaOrder.find(order_id)
  #Render the show page for that orders
  erb(:show)
end


get '/pizza-orders/:id/edit' do
  order_id = params[:id]
  @order = PizzaOrder.find(order_id)
  erb(:edit)
end

post '/pizza-orders' do
  @order = PizzaOrder.new(params) #create a new pizza order
  @order.save() # will save the order to database
  erb(:create)
end

# to save the update.
post '/pizza-orders/:id' do
  # @order = PizzaOrder.find(params)
  @order = PizzaOrder.new(params)
  @order.update()
  redirect "/pizza-orders"
end

get '/pizza-orders/:id/updated' do
  redirect "/pizza-orders"
end



#This route should accept post requests on pizza-orders.
#then take the post paramiters
#then create a new pizza order.


# post '/pizza-orders/:id' do
#   @order = PizzaOrder.new(params)
#   @order.update()
#   erb(:updated)
# end

#delete an order
post '/pizza-orders/:id/delete' do
  @order = PizzaOrder.find(params[:id])
  @order.delete()
  erb(:deleted)
end
