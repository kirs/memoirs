$(function() {
  var collectionTemplateScript = $("#gem_list")
  var versionTemplateScript = $("#version_modal")

  var collectionTemplate = Handlebars.compile(collectionTemplateScript.html())
  var versionTemplate = Handlebars.compile(versionTemplateScript.html())

  openVersionModal = function(version) {
    var modal = versionTemplate(version)
    modal = $(modal)

    modalBlock = $(".modal")
    $(".modal").empty()

    modalBlock.append(modal)
    modalBlock.modal()
  }

  displayVersion = function(gemName, versionNumber) {
    if(!window.gems) {
      $.getJSON("/ruby_gems/" + gemName + "/versions", function(gemVersions) {
        var targetVersion = _.find(gemVersions, function(version) {
          return version.number == versionNumber
        })

        targetVersion = $.extend(targetVersion, { gem: {name: "loaded"} })
        openVersionModal(targetVersion)
      })
      return
    }
    var gem = _.find(window.gems, function(gem) {
      return gemName == gem.name
    })

    var version = _.find(gem.versions, function(version) {
      return version.number == versionNumber
    })

    version = $.extend(version, { gem: gem })

    openVersionModal(version)
  }

  $.getJSON("/ruby_gems", function(loadedGems) {
    window.gems = loadedGems
    $("#popular_gems_container").append(collectionTemplate(loadedGems))
  })

  $(window).on('popstate', function(event) {
    hash = document.location.hash

    if(result = hash.match(/#!\/([a-z]*)\/([\w.]*)/)) {
      gemName = result[1]
      versionNumber = result[2]

      displayVersion(gemName, versionNumber)
    }
  })

  $('.modal').on('hidden.bs.modal', function () {
    console.log("on hide")
    history.pushState(null, null, "/frontend/")
  })
})
