<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>Index</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>


    <script>       
        $(document).ready(function () {
            $('#my-submodal')
                .on('beforeShow', function () { console.log('Submodal beforeShow event'); })
                .on('show', function () { console.log('Submodal show event'); })
                .on('beforeHide', function () { console.log('Submodal beforeHide event'); })
                .on('hide', function () { console.log('Submodal hide event'); });
        });
    </script>

</head>

<body>
    <br />
    <div class="row">
        <div class="container">
         	<a href="#my-modal" class="btn btn-default" data-bs-toggle="modal">Show Modal</a>
           	<div class="modal fade" id="my-modal" style="height:auto;">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<a href="#" class="close" data-bs-dismiss="modal">
								<span aria-hidden="true">&times;</span>
                                <span class="sr-only">Close</span>
                            </a>
                            <h4 class="modal-title">Your Account</h4>
                        </div>
                        <div class="modal-body">
                            <!-- SUBMODAL -->
                            <div class="modal submodal" id="my-submodal">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            <p class="text-center">Are you sure you want to close your account?<br />You won't be able to undo this.</p>
                                            <hr />
                                            <form class="form-horizontal">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label" for="pass">Password:</label>
                                                    <div class="col-sm-9">
                                                        <input type="password" class="form-control" id="pass">
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        
                                        <div class="modal-footer">
                                            <button class="btn btn-default" data-bs-dismiss="submodal" aria-hidden="true">Cancel</button>
                                            <button class="btn btn-danger" data-bs-dismiss="submodal">Close Account</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- /SUBMODAL -->
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label">Your Account</label>
                                    <div class="col-sm-8">
                                        <a href="#my-submodal" role="button" class="btn btn-default btn-xs" data-bs-toggle="submodal">서브모달</a>
                                        <p>Using a submodal to do something as serious as close an account is shitty UX, Jacob</p>                                       

                                        <p>Using a submodal to do something as serious as close an account is shitty UX, Jacob</p>                                       

                                        <p>Using a submodal to do something as serious as close an account is shitty UX, Jacob</p>                                       

                                        <p>Using a submodal to do something as serious as close an account is shitty UX, Jacob</p>                                       

                                        <p>Using a submodal to do something as serious as close an account is shitty UX, Jacob</p>                                       

                                        <p>Using a submodal to do something as serious as close an account is shitty UX, Jacob</p>                                       

                                    </div>

                                    <div class="col-sm-12"></div>

                                    <div class="col-sm-12"></div>

                                </div>                               

                            </form>

                        </div> <!-- /.modal-body -->

                    </div>

                </div>

            </div>

 

        </div>

    </div>     

</body>

</html>

 