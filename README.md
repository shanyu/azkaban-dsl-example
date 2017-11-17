## Azkaban DSL examples that works on HDInsight clusters

This is adapted from example-project at:
https://github.com/linkedin/linkedin-gradle-plugin-for-apache-hadoop

Make sure you install an Azkaban server on headnode or edgenode of HDInsight cluster.
Then ssh to that node.

### Build
```
gradle build
```

### Upload artifacts
```
gradle azkabanUpload --no-daemon -PskipInteractive
```

### Run workflows and check results
```
gradle azkabanExecuteFlow --no-daemon -PskipInteractive -Pflow=myWordCount2
gradle azkabanExecuteFlow --no-daemon -PskipInteractive -Pflow=sparkPi

gradle azkabanFlowStatus --no-daemon -PskipInteractive -Pflow=myWordCount2
gradle azkabanFlowStatus --no-daemon -PskipInteractive -Pflow=sparkPi
```
