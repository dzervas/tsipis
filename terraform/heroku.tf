resource "heroku_app" "tsipis" {
  name = var.project_name
  region = var.heroku_region
}

resource "heroku_addon" "tsipis_db" {
  app = heroku_app.tsipis.name
  # Free plan of postgres
  plan = "heroku-postgresql:hobby-dev"
}
