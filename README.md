# Inventory Management System

An inventory system targeted for organizations to keep track of their fixed and non fixed items in stock. Fixed items include the company's long term investment assets. 
Examples of fixed items may include- machinery, computer equipment, vehicles, etc.
The things which might come under non fixed items includes- inventory, items in stock and any other kind of property that you hold solely for the purpose of use within the organization for daily purpose.

Features include:

* Import items through csv or excel file
* Add categories to items
* Manage item purchase
* Withdraw non fixed item from inventory
* Assign fixed item to employee
* Return assigned item back to inventory
* Transfer items between employees
* Invite employees
* Employee can request for an item

## Requirements

* Ruby - ruby 2.6.3p62 (2019-04-16 revision 67580)
* Rails - Rails 6.0.0.rc2
* Postgresql - psql 10.10 

## Installation
```
$ git clone https://github.com/roshita02/jyaasa_inventory.git
$ cd jyaasa_inventory

$ bundle install
$ rake db:create
$ rake db:migrate
$ rake db:seed
```
## Login

**For admin login**

email: admin@example.com 
password: password

## Built With

* [ActiveAdmin](https://activeadmin.info/) - The administration framework used
* [Chartkick](https://chartkick.com/) - Implementing Charts
* [RSpec](https://rspec.info/documentation/) - Used for testing

## Authors

* **Roshita Shakya** 

## License

This project is licensed under **Jyaasa Technologies Pvt Ltd.**
