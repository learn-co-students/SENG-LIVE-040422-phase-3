# Sinatra API CRUD and Relationships

## Today's Focus

- How we make decisions about how to structure data from our API given the features we want for our react application
- retrieving related records via our API.
- using the options on the `to_json` method to customize the information we see about associated database records in API responses.


In our previous lecture, we reviewed how to handle CRUD operations by building out the following endpoints:

- `get '/dogs'`
- `post '/dogs'`
- `patch '/dogs/:id'`
- `delete '/dogs/:id'`

For this lecture, we'll be working on building out CRUD functionality for the Walks and DogWalks resources.

We'll be using this [POSTMAN workspace](https://www.postman.com/dakota27/workspace/dogwalkerapplication) to test out our API. You should be able to find it on your local postman client and use it to interact with the API.

We'll also be referring to the [Dog Walker API documentation](./api-docs/index.html) (opened in the browser) for a reference on what our desired behavior should be.


## How to include relationships within our API's JSON responses

The way we'll include these relationships with the JSON responses is by using the `include` option for the `to_json` method.

```rb
# t.string :username
# t.string :email
class User < ActiveRecord::Base
  has_many :posts
end

# t.string :title
# t.text :content
class Post < ActiveRecord::Base
  belongs_to :user

  def reading_time
    words_per_minute = 180

		words = content.split.size;
		minutes = ( words / words_per_minute ).floor
		minutes_label = minutes === 1 ? " minute" : " minutes"
		minutes > 0 ? "about #{minutes} #{minutes_label}" : "less than 1 minute"
  end
end

# t.string :content
# t.integer :user_id
# t.integer :post_id
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  delegate :username, to: :user
end

User.first.to_json(
  only: [:username],
  include: {
    posts: {
      only: [
        :id, 
        :title
      ],
      methods: [:reading_time]
      include: {
        comments: {
          only: [:content],
          methods: [:username]
        }
      }
    }
  }
)

{
  username: "Dakota",
  posts: [
    { 
      id: 1, 
      title: "My first post", 
      reading_time: "less than 1 minute", 
      comments: [
        { 
          content: "so short!",
          username: "So meone"
        }
      ] 
    },
    { 
      id: 2, 
      title: "The second post", 
      reading_time: "about 4 minutes", 
      comments: [
        { 
          content: "love this post",
          username: "Noo ne"
        }
      ]
    },
    { 
      id: 3,
      title: "A funny post",
      reading_time: "about 3 minutes", 
      comments: [
        { 
          content: "haha",
          username: "Nob ody"
        }
      ]
    }
  ]
}
```

#### Resources

- [to_json docs](https://apidock.com/rails/ActiveRecord/Serialization/to_json)
- [Preview of Serialization in Rails](https://thoughtbot.com/blog/better-serialization-less-as-json)

### DRY serialization

Converting an object or collection of objects to JSON format is referred to as serialization. As our logic for serialization becomes more complicated, we'll want to pull it out of individual endpoints so we don't have to repeat it 3 or more times within our controller. 

> When we get to Rails in Phase 4, you'll learn another way of serializing objects/collections that involves creating separate files called serializers. For now, we'll just add a private method to our controller called `serialize` and invoke it from each endpoint.

```rb
class UsersController < ApplicationController
  get "/users" do 
    serialize(User.all)
  end

  get "/users/:id" do 
    serialize(User.find(params[:id]))
  end

  # ...

  private

  def serialize(objects)
    objects.to_json(
      only: [:username],
      include: {
        posts: {
          only: [
            :id, 
            :title
          ],
          methods: [:reading_time],
          include: {
            comments: {
              only: [:content],
              methods: [:username]
            }
          }
        }
      }
    )
  end
end
```


