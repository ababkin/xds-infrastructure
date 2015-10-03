rails sync (direct) download
  -> notify DownloadCompleteSNS

rails async (from remote link) download
  -> enq DownloadQueue 

deq DownloadQueue
    -> run background downloader
      -> notify DownloadCompleteSNS


DownloadCompleteSNS
  -> HTTPS xds updates subscriber (main site)
  -> enq ArchiveQueue
  -> enq ProcessQueue
  -> enq NotifyQueue

deq ArchiveQueue
  -> run archiver (.csv -> .zip)
    -> notify ArchiveCompleteSNS

ArchiveCompleteSNS
  -> HTTPS xds updates subscriber (main site)
  -> enq NotifyQueue

deq ProcessQueue
  -> run processor 
    -> notify ArchiveCompleteSNS

ProcessCompleteSNS
  -> HTTPS xds updates subscriber (main site)
  -> enq IndexQueue
  -> enq NotifyQueue

deq IndexQueue
  -> run indexer 
    -> notify IndexCompleteSNS

IndexCompleteSNS
  -> HTTPS xds updates subscriber (main site)





