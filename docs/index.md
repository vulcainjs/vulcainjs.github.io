---
template: home.html
---

<style>
<style>
  .lead {
    color: #555;
    font-weight: normal;
  }
  
  .btn-default {
    background-image: linear-gradient(#fff, #fff 60%, #f5f5f5);
    border-bottom: 1px solid #e6e6e6;
  }
  
  .head-banner-text {
    padding: 20px 0 0 0;
  }
  .head-banner-buttons {
    padding: 0 0 20px;
  }  
</style>

<div class="row">
    <div id="myCarousel" class="col-md-offset-1 col-md-10 carousel slide" data-ride="carousel" data-interval="5000">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
            <li data-target="#myCarousel" data-slide-to="3"></li>
        </ol>

        <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <img  src="images/intro.png" alt="vulcain.js">                   
                </div>
                <div class="item">
                    <img class="img-responsive" src="images/intro2.png" alt="vulcain.js">
                </div>
                <div class="item">
                    <img class="img-responsive" src="images/intro3.png" alt="vulcain.js">
                </div>
                <div class="item">
                    <img class="img-responsive" src="images/intro4.png" alt="vulcain.js">
                </div>                
            </div>

            <!-- Left and right controls -->
            <a class="left carousel-control" style="background-image: none" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" style="background-image: none" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
    </div>
</div>
<div class="row head-banner-text">
    <p class="lead text-center col-md-12 col-xs-12">
        Open-Source Microservice Framework for nodejs (Preview)<br>
    </p>
</div>
<div class="row head-banner-buttons">
    <div class="col-md-offset-2 col-md-4 col-xs-12">
        <a href="https://github.com/vulcainjs/vulcain-corejs/zipball/master" class="btn btn-default btn-lg btn-block" style="padding: 14px 16px;">Download</a>
    </div>
    <div class="col-md-4  col-xs-12">
        <a href="http://github.com/vulcainjs/vulcain-corejs" class="btn btn-success btn-lg btn-block"  style="padding: 14px 16px;">View On GitHub</a>
    </div>
</div>
<div class="row">
    <div class="col-md-4">
        <h4>Features</h4>
        <p>
            <ul>
            <li>Fully docker deployable</li>
            <li>Hystrix command implementation (circuit-breaker, bulkhead, timeout)</li>
            <li>Context propagation (user context, correlation id...)
            <li>CQRS implementation</li>
            <li>Fully extensible whith adapters</li>
            <li>Input data validation</li>
            <li>Default implementation (MongoDb, rabbitmq, statsd, swarm)</li>
            <li>Authoring tool (Creating project from template, code generation...)</li>
            <li>Metrics generation</li>
            </ul>
        </p>
    </div>
    <div class="col-md-4">
        <h4>Enterprise ready</h4>
        <p>
            <ul>
            <li>Dynamic configuration properties</li>
            <li>Service versionning</li>
            <li>Feature teams and domains</li>
            <li>Environment management</li>
            <li>Built-in metadata service description (entry points description, service dependencies)</li>
            <li>Log obfuscation for sensible data</li>
            <li>User interface management for teams</li>
            <li>Automatic metrics generation</li>
            <li>Multi-tenants</li>
            <li>Distributed request log aggregation with correlation-id</li>
            </ul>
        </p>
    </div>
    <div class="col-md-4">
        <h4>Video overview</h4>
        <p class="video-wrapper">
            <iframe width="340" height="200" src="https://www.youtube.com/embed/LAQK-ZjW124" frameborder="0" allowfullscreen></iframe> 
        </p>
    </div>
</div>
