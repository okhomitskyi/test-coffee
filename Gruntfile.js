module.exports = function(grunt) {
  // Project configuration.
  grunt.loadNpmTasks("grunt-run");
  grunt.initConfig({
    run: {
      start: {
        cmd: "yarn",
        args: ["start"]
      }
    }
  });

  // Default task(s).
  grunt.registerTask("default", ["run:start"]);
};
