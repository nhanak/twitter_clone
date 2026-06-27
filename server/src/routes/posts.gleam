import gleam/dynamic/decode
import gleam/http.{Get, Post}
import gleam/json
import gleam/result
import wisp.{type Request, type Response}

pub type TwitterPost {
  TwitterPost(content: String, author: String)
}

pub fn handle_request(req: Request) -> Response {
  case req.method {
    Get -> list_posts()
    Post -> create_post(req)
    _ -> wisp.method_not_allowed([])
  }
}

fn list_posts() -> Response {
  let posts = [
    TwitterPost(content: "Hello, world!", author: "Neil"),
    TwitterPost(content: "Hello, world two!", author: "Neil"),
  ]

  json.array(posts, of: post_to_json)
  |> json.to_string
  |> wisp.json_response(200)
}

fn create_post(req: Request) -> Response {
  use json <- wisp.require_json(req)

  let result = {
    use twitter_post <- result.try(decode.run(json, post_decoder()))

    let object =
      json.object([
        #("content", json.string(twitter_post.content)),
        #("author", json.string(twitter_post.author)),
      ])

    Ok(json.to_string(object))
  }

  case result {
    Ok(json) -> wisp.json_response(json, 201)
    Error(_) -> wisp.unprocessable_content()
  }
}

fn post_to_json(post: TwitterPost) -> json.Json {
  json.object([
    #("content", json.string(post.content)),
    #("author", json.string(post.author)),
  ])
}

fn post_decoder() -> decode.Decoder(TwitterPost) {
  use content <- decode.field("content", decode.string)
  use author <- decode.field("author", decode.string)
  decode.success(TwitterPost(content:, author:))
}
