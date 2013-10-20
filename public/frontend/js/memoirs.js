$(function() {
  var collectionTemplateScript = $("#gem_list")
  var versionTemplateScript = $("#version_modal")

  var collectionTemplate = Handlebars.compile(collectionTemplateScript.html())
  var versionTemplate = Handlebars.compile(versionTemplateScript.html())

  openVersionModal = function(version) {
    version.formatted = new Handlebars.SafeString(markdown.toHTML(version.release_notes))

    var modal = versionTemplate(version)
    modal = $(modal)

    modalBlock = $(".modal")
    $(".modal").empty()

    modalBlock.append(modal)
    modalBlock.modal()
  }

  findVersionInCollection = function(versions, versionNumber) {
    return _.find(versions, function(version) {
      return version.number == versionNumber
    })
  }

  Memoirs = {
    stateChanged: function(event) {
      hash = document.location.hash

      if(result = hash.match(/#!\/([a-z]*)\/([\w.]*)/)) {
        gemName = result[1]
        versionNumber = result[2]

        Memoirs.displayVersion(gemName, versionNumber)
      }
    },

    displayVersion: function(gemName, versionNumber) {
      if(!Memoirs.loadedGems) {
        delayedLoad(gemName, versionNumber)
        return
      }

      var gem = _.find(Memoirs.loadedGems, function(gem) {
        return gemName == gem.name
      })
      version = findVersionInCollection(gem.versions, versionNumber)
      // if version == undefined, show NOT FOUND

      versionWithGem = $.extend(version, { gem: gem })

      openVersionModal(versionWithGem)
    },

    fetchList: function(limit) {
      url = "/ruby_gems?limit=" + limit
      $.getJSON(url, function(gems) {
        Memoirs.loadedGems = gems
        $("#popular_gems_container").append(collectionTemplate(gems))
      })
    }
  }
  delayedLoad = function(gemName, versionNumber) {
    url = "/ruby_gems/" + gemName + "/versions?specific=" + versionNumber
    $.getJSON(url, function(gemVersions) {
      if(gemVersions.status == "processing") {
        fakeVersion = {
          release_notes: "Loading gem meta...",
          gem: {
            name: gemName
          }
        }
        openVersionModal(fakeVersion)

        Memoirs.asyncFetcher = setTimeout(function() {
          delayedLoad(gemName, versionNumber)
        }, 3000)
      } else {
        targetVersion = findVersionInCollection(gemVersions, versionNumber)

        targetVersion = $.extend(targetVersion, { gem: {name: gemName} })
        openVersionModal(targetVersion)
      }
    })
  }

  Memoirs.fetchList(10)

  $(window).on('popstate', Memoirs.stateChanged)

  // back on modal hide
  $('.modal').on('hidden.bs.modal', function () {
    window.clearInterval(Memoirs.asyncFetcher)
    history.pushState(null, null, "/frontend/")
  })
})
