import gleam/int
import lustre
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

type Model {
  Model(post_input: String)
}

fn init(_args) -> Model {
  Model(" ")
}

type Message {
  UserChangedPostInput(String)
}

fn update(model: Model, message: Message) -> Model {
  case message {
    UserChangedPostInput(new_post_input) -> Model(new_post_input)
  }
}

fn view(model: Model) -> Element(Message) {
  html.div(
    [
      attribute.class("flex justify-center h-screen bg-black"),
    ],
    [
      post_input(UserChangedPostInput, model),
    ],
  )
}

fn post_input(on_user_changed_post_input, model: Model) -> Element(message) {
  html.div([attribute.class("text-white")], [
    html.input([
      attribute.value(model.post_input),
      event.on_input(on_user_changed_post_input),
      attribute.class("border border-solid border-white"),
    ]),
    html.button(
      [attribute.class("border border-solid border-white rounded-lg px-2")],
      [
        html.text("Post"),
      ],
    ),
  ])
}

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}
