import routes/posts
import web
import wisp.{type Request, type Response}

pub fn handle_request(req: Request) -> Response {
  use req <- web.middleware(req)
  case wisp.path_segments(req) {
    ["api", "posts"] -> posts.handle_request(req)
    _ -> wisp.not_found()
  }
}
