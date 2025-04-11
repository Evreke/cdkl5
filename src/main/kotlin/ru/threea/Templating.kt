package ru.threea

import freemarker.cache.ClassTemplateLoader
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.http.content.*
import io.ktor.server.routing.*
import java.io.File

fun Application.configureTemplating() {
  install(FreeMarker) {
    templateLoader = ClassTemplateLoader(this::class.java.classLoader, "templates")
  }

  val title = "Сообщество пациентов CDKL5"

  val aboutCdkl = "О CDKL5"
  val genetics = "Генетика CDKL5"
  val treatment = "О лечении"
  val aboutUs = "О нас"

  val pages = listOf(
    Page("/", title, "pages/main.ftl"),
    Page("/about-cdkl5", aboutCdkl, "pages/about-cdkl5.ftl"),
    Page("/genetics", genetics, "pages/genetics.ftl"),
    Page("/treatment", treatment, "pages/treatment.ftl"),
  )

  val menuStructure = listOf(
    MenuItem("/about-cdkl5", aboutCdkl),
    MenuItem("/genetics", genetics),
    MenuItem("/treatment", treatment),
  )


  routing {
    staticResources("/static", "static") {
    }

    get("/") {
      call.respondTemplate(
        "index.ftl",
        mapOf("content" to "pages/main.ftl", "title" to title, "currentPage" to "/", "menu" to menuStructure),
        ""
      )
    }

    pages.forEach { page ->
      get(page.path) {
        call.respondTemplate(
          "index.ftl",
          mapOf("content" to page.template, "title" to page.title, "currentPage" to page.path, "menu" to menuStructure),
          ""
        )
      }
    }
  }
}

private data class Page(val path: String, val title: String, val template: String)

data class MenuItem(
  val path: String,
  val title: String,
  val children: List<MenuItem> = emptyList()
)

