---
template: home.html
---

<style>
.lead {
    color:#555;
    font-weight: normal;
}
.btn-default {
    background-image: linear-gradient(#fff,#fff 60%,#f5f5f5);    
    border-bottom: 1px solid #e6e6e6;    
}
.btn-lg: {
    font-size: 18px;
    line-height: 1.33;
    border-radius: 6px;
    color: #555;
    background-color: #fff;
    border-color: rgba(0,0,0,0.1);    
}
.head-banner-text {
    padding: 10px;
}
.head-banner {
    padding: 90px 0 20px 0;
}
.col-md-9 img {
    padding: 0px;
    margin: 0;
}
.col-md-9 {
    width: 90%;
}
.md-header a {
    color: white;
}
.md-header a:hover {
    text-decoration: none;
}
.nav li a:hover {
    background-color: #2196f3;
    color: hsla(0,0%,100%,.7);    
}

.btn-success {
    background-image: linear-gradient(#88c149,#73a839 60%,#699934);
}
</style>

<div class="head-banner">
    <div class="row">
        <div class="col-md-10 col-md-offset-1"> 
            <img class="img-responsive" src="images/intro.png" alt="vulcain.js">
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
</div>

<div>
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
