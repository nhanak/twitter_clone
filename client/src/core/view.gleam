import core/model.{type Message, type Model, UserChangedPostInput}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

pub fn view(model: Model) -> Element(Message) {
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
  html.div([attribute.class("flex flex-col text-white mt-20")], [
    html.textarea(
      [
        event.on_input(on_user_changed_post_input),
        attribute.class(
          "border border-solid border-white h-24 w-xl resize-none",
        ),
      ],
      model.post_input,
    ),
    html.button(
      [
        attribute.class(
          "mt-2 border border-solid border-white rounded-lg px-2 hover:bg-white hover:text-black",
        ),
      ],
      [
        html.text("Post"),
      ],
    ),
  ])
}
