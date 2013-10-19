$(function() {
  var collectionTemplateScript = $("#gem_list")
  var versionsTemplateScript = $("#version_list")

  if(collectionTemplateScript.length > 0) {
    var collectionTemplate = Handlebars.compile(collectionTemplateScript.html())
    $.getJSON("/ruby_gems", function(gems) {
      $("#popular_gems_container").append(collectionTemplate(gems))
    })

    $(document).on("click", ".open-version", function() {
      alert("open " + $(this).text())
    })
  }
})
