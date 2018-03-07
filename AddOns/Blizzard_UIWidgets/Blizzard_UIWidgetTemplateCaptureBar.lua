local function GetCaptureBarVisInfoData(widgetID)
	local widgetInfo = C_UIWidgetManager.GetCaptureBarWidgetVisualizationInfo(widgetID);
	if widgetInfo and widgetInfo.state > Enum.CaptureBarWidgetState.Hidden then
		return widgetInfo;
	end
end

UIWidgetManager:RegisterWidgetVisTypeTemplate(Enum.UIWidgetVisualizationType.CaptureBar, {frameType = "FRAME", frameTemplate = "UIWidgetTemplateCaptureBar"}, GetCaptureBarVisInfoData);

UIWidgetTemplateCaptureBarMixin = {}

local CAPTURE_BAR_STYLE = {
	["PVP"] = { BarBackground = "worldstate-capturebar-frame-factions", LeftBar = "worldstate-capturebar-blue", RightBar = "worldstate-capturebar-red", Middle="worldstate-capturebar-spark-yellow" },
	["LFD_BATTLEFIELD"] = { BarBackground = "worldstate-capturebar-frame", LeftBar = "worldstate-capturebar-yellow", RightBar = "worldstate-capturebar-purple", Middle="worldstate-capturebar-spark-green" },
};

local LEFT_BAR_OFFSET = 25;
local FULL_BAR_SIZE = 124;
local MIDDLE_BAR_SIZE = 121;

function UIWidgetTemplateCaptureBarMixin:Setup(widgetInfo)
	local halfNeutralPercent = widgetInfo.neutralPercent / 2;

	local position = LEFT_BAR_OFFSET + FULL_BAR_SIZE * (1 - widgetInfo.barPercent);
	if ( not self.oldValue ) then
		self.oldValue = position;
	end

	-- style
	local style = "PVP";
	if ( IsInLFDBattlefield() ) then
		style = "LFD_BATTLEFIELD"
	end
	if ( self.style ~= style ) then
		self.style = style;
		for key, atlas in pairs(CAPTURE_BAR_STYLE[style]) do
			if ( self[key] ) then
				self[key]:SetAtlas(atlas);
			else
				self.Indicator[key]:SetAtlas(atlas);
			end
		end
	end

	-- Left/Right indicators
	if ( position < self.oldValue ) then
		self.Indicator.FlashLeftAnim:Play();
		self.Indicator.FlashRightAnim:Stop();
		self.Indicator.Right:SetAlpha(0);
	elseif ( position > self.oldValue ) then
		self.Indicator.FlashLeftAnim:Stop();
		self.Indicator.Left:SetAlpha(0);
		self.Indicator.FlashRightAnim:Play();
	else
		self.Indicator.FlashLeftAnim:Stop();
		self.Indicator.Left:SetAlpha(0);
		self.Indicator.FlashRightAnim:Stop();
		self.Indicator.Right:SetAlpha(0);
	end

	-- Figure out if the ticker is in neutral territory or on a faction's side
	if ( widgetInfo.barPercent > (0.5 + halfNeutralPercent) ) then
		self.LeftIconHighlight:Show();
		self.RightIconHighlight:Hide();
	elseif ( widgetInfo.barPercent < (0.5 - halfNeutralPercent) ) then
		self.LeftIconHighlight:Hide();
		self.RightIconHighlight:Show();
	else
		self.LeftIconHighlight:Hide();
		self.RightIconHighlight:Hide();
	end

	-- Setup the size of the neutral bar
	if ( widgetInfo.neutralPercent == 0 ) then
		self.MiddleBar:SetWidth(1);
		self.LeftLine:Hide();
	else
		self.MiddleBar:SetWidth(widgetInfo.neutralPercent * MIDDLE_BAR_SIZE);
		self.LeftLine:Show();
	end

	self.oldValue = position;
	self.Indicator:SetPoint("CENTER", self, "LEFT", position, 0);

	self:SetShown(true);
	self.orderIndex = widgetInfo.orderIndex;
end
