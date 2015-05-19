﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ActivitySelect.ascx.cs" Inherits="RockWeb.Plugins.cc_newspring.AttendedCheckin.ActivitySelect" %>

<asp:UpdatePanel ID="pnlContent" runat="server" UpdateMode="Conditional">
    <ContentTemplate>

        <asp:HiddenField ID="hfAllergyAttributeId" runat="server" />

        <asp:Panel ID="pnlActivities" runat="server" CssClass="attended">

            <Rock:ModalAlert ID="maWarning" runat="server" />

            <div class="row checkin-header">
                <div class="col-xs-3 checkin-actions">
                    <Rock:BootstrapButton ID="lbBack" CssClass="btn btn-primary btn-lg" runat="server" OnClick="lbBack_Click" EnableViewState="false">
                    <span class="fa fa-arrow-left"></span>
                    </Rock:BootstrapButton>
                </div>

                <div class="col-xs-6 text-center">
                    <h1>
                        <asp:Literal ID="lblPersonName" runat="server" EnableViewState="false" /></h1>
                </div>

                <div class="col-xs-3 checkin-actions text-right">
                    <Rock:BootstrapButton ID="lbNext" CssClass="btn btn-primary btn-lg" runat="server" OnClick="lbNext_Click" EnableViewState="false">
                     <span class="fa fa-arrow-right"></span>
                    </Rock:BootstrapButton>
                </div>
            </div>

            <div class="row checkin-body">
                <div class="col-xs-3">
                    <asp:UpdatePanel ID="pnlGroupTypes" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <h3 class="text-center">GroupType</h3>
                            <asp:ListView ID="lvGroupType" runat="server" OnItemCommand="lvGroupType_ItemCommand" OnPagePropertiesChanging="lvGroupType_PagePropertiesChanging" OnItemDataBound="lvGroupType_ItemDataBound">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbGroupType" runat="server" CssClass="btn btn-primary btn-lg btn-block btn-checkin-select" CausesValidation="false" />
                                </ItemTemplate>
                            </asp:ListView>
                            <asp:DataPager ID="dpGroupType" runat="server" PageSize="5" PagedControlID="lvGroupType">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="pagination btn btn-primary btn-checkin-select" />
                                </Fields>
                            </asp:DataPager>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="col-xs-3">
                    <asp:UpdatePanel ID="pnlLocations" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <h3 id="hdrLocations" runat="server" class="text-center">Location</h3>
                            <asp:ListView ID="lvLocation" runat="server" OnPagePropertiesChanging="lvLocation_PagePropertiesChanging" OnItemCommand="lvLocation_ItemCommand" OnItemDataBound="lvLocation_ItemDataBound">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbLocation" runat="server" CssClass="btn btn-primary btn-lg btn-block btn-checkin-select"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:ListView>
                            <asp:DataPager ID="dpLocation" runat="server" PageSize="5" PagedControlID="lvLocation">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="pagination btn btn-primary btn-checkin-select" />
                                </Fields>
                            </asp:DataPager>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="col-xs-3">
                    <asp:UpdatePanel ID="pnlSchedules" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <h3 class="text-center">Schedule</h3>
                            <asp:Repeater ID="rSchedule" runat="server" OnItemCommand="rSchedule_ItemCommand" OnItemDataBound="rSchedule_ItemDataBound">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbSchedule" runat="server" CssClass="btn btn-primary btn-lg btn-block btn-checkin-select" CausesValidation="false" />
                                </ItemTemplate>
                            </asp:Repeater>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="col-xs-3 selected-grid">
                    <h3 class="text-center">Selected</h3>
                    <asp:UpdatePanel ID="pnlSelected" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="grid">
                                <Rock:Grid ID="gSelectedGrid" runat="server" ShowHeader="false" ShowFooter="false" EnableResponsiveTable="true" DisplayType="Light"
                                    DataKeyNames="GroupId, LocationId, ScheduleId" EmptyDataText="No Locations Selected">
                                    <Columns>
                                        <asp:BoundField ItemStyle-CssClass="col-xs-3" DataField="Schedule" />
                                        <asp:BoundField ItemStyle-CssClass="col-xs-8" DataField="Location" />
                                        <Rock:DeleteField ItemStyle-CssClass="col-xs-1" ControlStyle-CssClass="btn btn-lg accent-bold-color accent-bold-color-bordered" OnClick="gSelectedGrid_Delete" />
                                    </Columns>
                                </Rock:Grid>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

            <div class="checkin-footer bottom-corner col-xs-3 col-xs-offset-9">
                <div class="">
                    <asp:LinkButton ID="lbEditInfo" runat="server" Text="Edit Info" CssClass="btn btn-primary btn-block btn-checkin-select" OnClick="lbEditInfo_Click" CausesValidation="false" />
                </div>
            </div>
        </asp:Panel>

        <!-- EDIT INFO MODAL -->
        <Rock:ModalDialog ID="mdlInfo" runat="server" Content-DefaultButton="lbSaveEditInfo">
            <Content>
                <div class="soft-quarter-ends">
                    <div class="row checkin-header">
                        <div class="col-xs-3 checkin-actions">
                            <Rock:BootstrapButton ID="lbCloseEditInfo" runat="server" CssClass="btn btn-lg btn-primary"
                                OnClick="lbCloseEditInfo_Click" Text="Cancel" EnableViewState="false" />
                        </div>

                        <div class="col-xs-6 text-center">
                            <h2>Edit Info</h2>
                        </div>

                        <div class="col-xs-3 checkin-actions text-right">
                            <Rock:BootstrapButton ID="lbSaveEditInfo" ValidationGroup="Person" CausesValidation="true" CssClass="btn btn-lg btn-primary" runat="server"
                                OnClick="lbSaveEditInfo_Click" Text="Save" EnableViewState="false" />
                        </div>
                    </div>

                    <div class="checkin-body">
                        <div class="row">
                            <div class="col-xs-2">
                                <Rock:RockTextBox ID="tbFirstName" runat="server" Label="First Name" ValidationGroup="Person" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:RockTextBox ID="tbNickname" runat="server" ValidationGroup="Person" Label="Nickname" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:RockTextBox ID="tbLastName" runat="server" Label="Last Name" ValidationGroup="Person" />
                            </div>
                            <div class="col-xs-1">
                                <Rock:RockDropDownList ID="ddlSuffix" runat="server" Label="Suffix" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:DatePicker ID="dpDOB" runat="server" Label="Date of Birth" ValidationGroup="Person" CssClass="date-picker" data-show-age="true" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:RockDropDownList ID="ddlAbility" runat="server" Label="Ability/Grade" />
                            </div>
                            <div class="col-xs-1 shift-up centered">
                                <Rock:RockCheckBox ID="cbSpecialNeeds" runat="server" Label="Special Needs" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6">
                                <Rock:RockTextBox ID="tbNoteText" runat="server" Label="Notes" MaxLength="40" />
                            </div>
                            <div class="col-xs-6">
                                <asp:PlaceHolder ID="phAttributes" runat="server" EnableViewState="false"></asp:PlaceHolder>
                            </div>
                        </div>
                    </div>
                </div>
            </Content>
        </Rock:ModalDialog>
    </ContentTemplate>
</asp:UpdatePanel>

<script type="text/javascript" src="../plugins/cc_newspring/attendedcheckin/scripts.js"></script>