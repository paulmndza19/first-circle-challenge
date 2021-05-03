# First Circle Coding Challenge

### Rails version 5.1.7

## Dependencies
1. [Postgresql](https://www.postgresql.org/)


### How to run app.
1. First, make sure that ruby is installed in your system. If not visit this link for a detailed guide on how to install ruby.
    * OSX - [Install ruby on OSX](https://stackify.com/install-ruby-on-your-mac-everything-you-need-to-get-going/)
    * Linux - [Install ruby on Linux](https://linuxize.com/post/how-to-install-ruby-on-ubuntu-18-04/)
2. Clone this repo\
    ```git clone https://github.com/paulmndza19/tribe-post-bundles.git```
3. Go inside the directory.\
    ```first-circle-challenge```
4. Create database\
    ```rails db:create```\
    ```rails db:migrate```
5. Create initial data for products and promotions
    ```rails db:seed```
6. Run the server\
    ```rails s```
7. In your browser, Go to `localhost:3000`. You should see a form for creating orders.
8. Fill-in the input fields, customer name and customer address field are required.
9. To add a line item, click the blue `+` button on the right.
10. To remove a line item form click the red `-` button beside it.
11. Click submit if you're done.

After clicking submit, you should be redirected to a page where you can see the tally of your order.


### How to run tests
#### Model tests
  ``` rails test test/models```
#### Services test
  ``` rails test test/services```
#### System test
  ``` rails test test/system```
### Controllers test
  ``` rails test test/controllers```
  
  
