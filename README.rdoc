Just `bundle install` and try to

```
rspec --require ./spec/rails_helper.rb
```
Specs should pass.

```
 OJ_ENABLED=true rspec --require ./spec/rails_helper.rb
 ```
 Specs should fail.

 There also should be some puts output which can be compared.
