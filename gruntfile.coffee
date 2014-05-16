directoryConfig =
  appSrc         : "app/src"
  appDist        : "app/dist"
  appStyleSheets : "/client/assets/stylesheets"

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json"),
    watch:
      options:
        livereload: true
      jade:
        files:
          directoryConfig.appSrc+"/**/*.jade"
        tasks:
          "jade"
      coffee:
        files:
          directoryConfig.appSrc+"/**/*.coffee"
        tasks:
          "coffee"
      compass:
        files:
          directoryConfig.appSrc+"/**/*.sass"
        tasks:
          "compass"
      image:
        files:
          directoryConfig.appSrc+"/**/*.{png,gif}"
        tasks:
          "imagemin"

    jade:
      compile:
        options:
          pretty: true
        files: [
          expand: true
          cwd  : directoryConfig.appSrc
          src  : "**/*.jade"
          dest : directoryConfig.appDist
          ext  : ".html"
        ]

    coffee:
      options:
        bare: true
      compile:
        files: [
          expand: true
          cwd  : directoryConfig.appSrc
          src  : "**/*.coffee"
          dest : directoryConfig.appDist
          ext  : ".js"
        ]

    compass:
      compile:
        options:
          require : "bootstrap-sass"
          bundleExec : true
          sassDir : "#{directoryConfig.appSrc}#{directoryConfig.appStyleSheets}"
          cssDir  : "#{directoryConfig.appDist}#{directoryConfig.appStyleSheets}"
          raw     : "output_style = :compressed\n"

    imagemin:
      png:
        options:
          optimizationLevel: 3
        files: [
          expand: true
          cwd: directoryConfig.appSrc
          src: "**/*.{png,gif}"
          dest: directoryConfig.appDist
        ]

    nodemon:
      dev:
        script: 'server.js'
        options:
          args: []
          ignoredFiles: ['public/**']
          watchedExtensions: ['js']
          nodeArgs: ['--debug']
          delayTime: 1
          env:
            PORT: 3000
          cwd: "#{__dirname}/app/dist/server"


    concurrent:
      dev:
        tasks: ["nodemon", "watch"]
        options:
          logConcurrentOutput: true
      build:
        tasks: ["jade", "coffee", "compass", "imagemin"]
        options:
          logConcurrentOutput: true
    

  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-imagemin"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-concurrent"
  grunt.loadNpmTasks "grunt-nodemon"

  grunt.registerTask "build", ["concurrent:build"]
  grunt.registerTask "default", ["build", "concurrent:dev"]
