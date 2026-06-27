pub type Model {
  Model(post_input: String)
}

pub type Message {
  UserChangedPostInput(String)
}

pub fn init(_args) -> Model {
  Model(" ")
}

pub fn update(model: Model, message: Message) -> Model {
  case message {
    UserChangedPostInput(new_post_input) -> Model(new_post_input)
  }
}
