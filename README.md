## Azkaban DSL examples that works on HDInsight clusters

Make sure you install an Azkaban server on headnode or edgenode.
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
