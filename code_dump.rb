# <div class="col-sm-4">
#   <div class="card">
#     <% if @user != nil %>
#     <h4>Welcome back: <%= @user.user_name %></h4>
#
#     <% else %>
#     <h4>Login:</h4>
#     <form class="" action="/login" method="get">
#       <div class="form-group">
#         <label for="user_name">User Name:</label>
#         <input class="form-control" type="text" name="user_name">
#       </div>
#       <div class="form-group">
#         <label for="user_password">Password:</label>
#         <input class="form-control" type="password" name="user_password">
#       </div>
#       <button class="btn btn-success" type="submit" name="button">Log In</button>
#     </form>
#     <br>
#     <small><a href="/sign_up">Not registered? Sign up here.</a></small>
#     <% end %>
#   </div>
# </div>
