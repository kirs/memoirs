$(function() {
  Handlebars.registerHelper( "join", function( array, sep, options ) {
    return array.map(function( item ) {
      return options.fn( item );
    }).join( sep );
  });

  var collectionTemplateScript = $("#gem_list")
  var versionTemplateScript = $("#version_modal")

  if(collectionTemplateScript.length > 0) {
    var collectionTemplate = Handlebars.compile(collectionTemplateScript.html())
    var versionTemplate = Handlebars.compile(versionTemplateScript.html())

    $.getJSON("/ruby_gems", function(gems) {
      window.gems = gems
      $("#popular_gems_container").append(collectionTemplate(gems))
    })

    $(document).on("click", ".open-version", function() {
      $(".modal").remove() // cleanup

      targerGemName = $(this).data('gem-name')
      targetVersion = $(this).data('version-number')

      var gem = _.find(window.gems, function(gem) {
        return targerGemName == gem.name
      })

      var version = _.find(gem.versions, function(version) {
        return version.number == targetVersion
      })

      version = $.extend(version, { gem: gem })

      var modal = versionTemplate(version)
      modal = $(modal)

      $("body").append(modal)
      $("body .modal").modal()
    })
  }
})
